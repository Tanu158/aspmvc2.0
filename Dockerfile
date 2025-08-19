# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy solution and project folder
COPY testing.sln ./
COPY testing/ ./testing/

# Restore dependencies using the solution file
RUN dotnet restore testing.sln

# Build and publish
RUN dotnet publish testing.sln -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "testing.dll"]
