package com.minhaempresa.springweb.application.resources.exceptions;

import com.minhaempresa.springweb.application.services.exceptions.DatabaseException;
import com.minhaempresa.springweb.application.services.exceptions.ResourceNotFoundException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.time.Instant;

@ControllerAdvice//essa anota��o intercepta as exceptions
public class ResourceExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<StandardError> resourceNorFoundException(ResourceNotFoundException resourceNotFoundException, HttpServletRequest httpServletRequest) {
        String errorMessage = "Resource not found";
        HttpStatus httpStatus = HttpStatus.NOT_FOUND;
        StandardError standardError = new StandardError(Instant.now(), httpStatus.value(), errorMessage, resourceNotFoundException.getMessage(), httpServletRequest.getRequestURI());
        return ResponseEntity.status(httpStatus).body(standardError);
    }

    @ExceptionHandler(DatabaseException.class)
    public ResponseEntity<StandardError> dataBaseException(DatabaseException databaseException, HttpServletRequest httpServletRequest) {
        String errorMessage = "Database error";
        HttpStatus httpStatus = HttpStatus.BAD_REQUEST;
        StandardError standardError = new StandardError(Instant.now(), httpStatus.value(), errorMessage, databaseException.getMessage(), httpServletRequest.getRequestURI());
        return ResponseEntity.status(httpStatus).body(standardError);
    }
}
