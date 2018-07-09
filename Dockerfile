FROM microsoft/dotnet:2.1-sdk-alpine AS build

# Set working directory within container
WORKDIR /app

# Copy files
COPY . .

# Restore dependencies
RUN dotnet restore

# Build app
RUN dotnet publish -c Release -o dist

# Build runtime image
FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine AS runtime
COPY --from=build /app/dist .
ENTRYPOINT ["dotnet", "demo-netcore-2x-api.dll"]

## Build the docker image
# docker build . -t demo-netcore-api

## Run the app
# docker run -it --rm -p 8000:80 --name demo-netcore-api demo-netcore-api

## Browse the app
# Navigate to http://localhost:8000/api/values
# On Windows you may need to navigate to the container via IP address.
# See https://github.com/dotnet/dotnet-docker/blob/master/samples/aspnetapp/aspnetcore-docker-windows.md

## Hosting images over HTTPS
# See https://github.com/dotnet/dotnet-docker/blob/master/samples/aspnetapp/aspnetcore-docker-https.md
