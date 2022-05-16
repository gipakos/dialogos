# Stage 1: Define base image that will be used for production
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /dialogos

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
EXPOSE 5000
WORKDIR /dialogos
COPY --from=build-env /dialogos/out .
ENTRYPOINT ["dotnet", "dialogos.dll"]




