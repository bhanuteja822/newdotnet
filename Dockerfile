FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

COPY dotnet6.csproj .
RUN dotnet restore

RUN apt-get update && apt-get install -y nodejs npm


COPY . .
RUN dotnet build -c Release --no-restore
RUN dotnet publish -c Release -o publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://*:5000

RUN groupadd -r bhanu && \
    useradd -r -g bhanu -s /bin/false bhanu && \
    chown -R bhanu:bhanu /app

USER bhanu

EXPOSE 5000
ENTRYPOINT ["dotnet", "dotnet6.dll"]
