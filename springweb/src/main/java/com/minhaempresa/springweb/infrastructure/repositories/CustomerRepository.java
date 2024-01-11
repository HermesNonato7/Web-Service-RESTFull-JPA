package com.minhaempresa.springweb.infrastructure.repositories;

import com.minhaempresa.springweb.infrastructure.models.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<Customer, String> {
}
