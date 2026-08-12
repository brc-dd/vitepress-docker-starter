# syntax=docker/dockerfile:1

FROM node:24-alpine AS base
WORKDIR /app
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME/bin:$PATH"
ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0
ENV pnpm_config_store_dir=/pnpm/store
RUN corepack enable

FROM base AS deps
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile

FROM deps AS dev
COPY --chmod=755 <<'EOF' /usr/local/bin/dev-entrypoint
#!/bin/sh
set -e
pnpm install
exec "$@"
EOF
ENTRYPOINT ["dev-entrypoint"]
EXPOSE 5173
CMD ["pnpm", "docs:dev", "--host"]

FROM deps AS build
COPY . .
RUN pnpm docs:build

FROM nginxinc/nginx-unprivileged:1.30-alpine AS prod
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/docs/.vitepress/dist /usr/share/nginx/html
EXPOSE 8080
