# Use the .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

# Set the working directory inside the container
WORKDIR /app

# Copy the .NET project file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code and build the project
COPY . ./
RUN dotnet publish -c Release -o out

# Use a smaller runtime image for the final image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app

# Copy the published output from the build-env stage
COPY --from=build-env /app/out .

# Set the entry point for the container
ENTRYPOINT ["dotnet", "YourAppName.dll"]  # Replace 'YourAppName.dll' with your actual entry point
