FROM python:3.10.7-slim

ENV PYTHONUNBUFFERED=1 COLUMNS=200 \
    DBT_PROFILES_DIR=/src

WORKDIR /src

ADD \
    ./src/poetry.toml \
    ./src/pyproject.toml \
    ./src/poetry.lock \
    ./src/dbt_project.yml \
    ./src/profiles.yml \
    ./src/packages.yml \
    /src/

# User local debian repositories
RUN apt update \
    && apt install -y apt-utils \
    procps libpq-dev git netcat \
# Set timezone
    && echo "UTC" > /etc/timezone \
# Upgrade pip
    && pip install --upgrade pip poetry \
# Add project dependencies
    && pip install poetry \
    && poetry install \
    && dbt deps --profiles-dir /src --project-dir /src \
# Remove build dependencies
    && apt clean autoremove --yes

COPY ./src /src

CMD ["./entrypoint.sh"]
