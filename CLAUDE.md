# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Structure

This is a full-stack checkout management application with separate front-end and back-end components:

- **Back-end**: Spring Boot Java application (`back-end/ueparent/`) using Spring Security, JPA/Hibernate, PostgreSQL
- **Front-end**: Angular 17 application (`front-end/`) with Angular Material UI components

### Architecture Overview

The back-end follows a layered architecture with clear separation:
- **Controllers**: REST API endpoints (`@RestController`)
- **Services**: Business logic layer (`@Service`)
- **Repositories**: Data access layer extending `JpaRepository`
- **DTOs**: Data transfer objects for API communication
- **Security**: JWT-based authentication with Spring Security

Key domains include:
- **User Management**: Authentication, authorization, user profiles
- **Real Estate**: Property management for checkout operations  
- **Tasks**: Task tracking with checklists, comments, and expenses
- **Notifications**: Email and WhatsApp messaging via Twilio
- **File Upload**: Image storage and retrieval

The front-end is a single-page application with:
- Component-based architecture using Angular modules
- Services for API communication and state management
- Guards for route protection
- Material Design components for UI

## Common Development Commands

### Back-end (Spring Boot)
```bash
cd back-end/ueparent

# Development
./mvnw spring-boot:run                    # Start development server
./mvnw clean compile                      # Compile code
./mvnw clean package                      # Build JAR
./mvnw test                              # Run all tests
./mvnw test -Dtest=ClassName             # Run specific test class
./mvnw clean                             # Clean build artifacts

# Note: Maven wrapper may need permissions: chmod +x mvnw
```

### Front-end (Angular)
```bash
cd front-end

# Development
npm start                                # Start dev server (http://localhost:4200)
ng serve                                # Alternative start command
ng build                                # Build for production
ng build --configuration development    # Build for development
ng test                                 # Run unit tests with Karma
ng generate component component-name    # Generate new component
```

## Configuration

### Back-end Environment Variables
Required environment variables for the Spring Boot application:
- `JWT_SECRET`: Secret key for JWT token generation
- `EMAIL_USERNAME`: Gmail SMTP username for email notifications  
- `EMAIL_PASS`: Gmail SMTP password/app password
- `TWILIO_SID`: Twilio account SID for WhatsApp messaging
- `TWILIO_TOKEN`: Twilio auth token
- `WHATSAPP_NUMBER`: Twilio WhatsApp number

### Database Setup
- PostgreSQL database required
- Application uses JPA with `hibernate.ddl-auto=update`
- Database connection configured via Spring profiles (dev/prod)
- Initial admin user created via `DataLoader` component

## Development Workflow

1. **Backend Development**: Start with `./mvnw spring-boot:run` in `back-end/ueparent/`
2. **Frontend Development**: Run `npm start` in `front-end/` directory  
3. **API Communication**: Frontend connects to backend at `/api` context path
4. **Authentication**: JWT tokens used for API authentication
5. **File Uploads**: Images stored via `FileUploadService` with 20MB limit

## Testing

- **Backend**: JUnit tests in `src/test/java/` - run with `./mvnw test`
- **Frontend**: Jasmine/Karma tests - run with `ng test`
- Test coverage includes service layer unit tests for core domains

## Key Dependencies

### Backend
- Spring Boot 3.2.2 with Java 17+
- Spring Security for authentication
- PostgreSQL database with JPA/Hibernate
- JWT tokens (jjwt library)
- Twilio SDK for WhatsApp messaging
- Spring Mail for email notifications

### Frontend  
- Angular 17 with TypeScript
- Angular Material for UI components
- RxJS for reactive programming
- JWT decode for token handling
- Toastr for notifications