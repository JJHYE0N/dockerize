FROM python:3.11

ENV SERVICE_NAME="my-service"
ARG APP_PATH="/my-fastapi"

WORKDIR $APP_PATH

# Enable virtualenv
ENV VIRTUAL_ENV="$APP_PATH/venv"
RUN python3.11 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip3 install poetry

# Poetry install
COPY . $APP_PATH
RUN poetry install
RUN python -m compileall ${APP_PATH}/app

# Run server
EXPOSE 8000
ENTRYPOINT ["poetry","run","python","-m","uvicorn","--host","0.0.0.0","dockerize.main:app"]