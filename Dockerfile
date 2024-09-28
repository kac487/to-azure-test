
FROM node:20

WORKDIR /app

# Install bun
RUN  npm install -g bun

COPY . .

RUN bun install --frozen-lockfile

# RUN bash ./prisma/generate-schema.sh typescript && bun prisma generate


ENV NEXT_TELEMETRY_DISABLED 1


# Envs are pulled in during build and used for type script validation
# The build will fail without these due to typescript checks
ENV POSTGRES_URL "BUILD"
ENV NEXTAUTH_SECRET "BUILD"


RUN SKIP_ENV_VALIDATION=1 bun run build

EXPOSE 3000
ENV PORT 3000
CMD [ "bun", "run", "start" ]
