# Build Phase
FROM node:alpine

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .

RUN npm run build

# Run Phase
FROM nginx

# EXPOSE by default does nothing. However AWS Elasticbeanstalk sees this instruction and exposes this port automatiaclly
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html

# No CMD needed because we're okay with the base images default command :)