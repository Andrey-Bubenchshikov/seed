FROM python:3.9.10-slim

ENV PYTHONUNBUFFERED=1 COLUMNS=200 \
    DBT_PROFILES_DIR=/src

ADD ./src/requirements.txt \
    ./src/dev_requirements.txt \
    ./src/dbt_project.yml \
    ./src/profiles.yml \
    ./src/packages.yml \
    /src/

# User local debian repositories
RUN sed -i "s/deb.debian.org/mirror.neolabs.kz/g" \
    /etc/apt/sources.list \
    && apt update \
    && apt install -y apt-utils \
    procps libpq-dev git netcat \
# Set timezone
    && echo "UTC" > /etc/timezone \
# Upgrade pip
    && pip install --upgrade pip wheel \
# Add project dependencies
    && pip install \
    --no-cache-dir -Ur /src/requirements.txt \
    --no-cache-dir -Ur /src/dev_requirements.txt \
    && dbt deps --profiles-dir /src --project-dir /src \
# Remove build dependencies
    && apt clean

COPY ./src /src
WORKDIR /src
CMD ["./entrypoint.sh"]
