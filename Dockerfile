# Build Phase
FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# Run Phase
FROM nginx

# EXPOSE by default does nothing. However AWS Elasticbeanstalk sees this instruction and exposes this port automatiaclly
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# No CMD needed because we're okay with the base images default command :)