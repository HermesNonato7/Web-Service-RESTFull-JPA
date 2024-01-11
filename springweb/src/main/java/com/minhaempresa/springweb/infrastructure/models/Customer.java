package com.minhaempresa.springweb.infrastructure.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/*
    Esta classe representa o modelo da entidade

    O modelo de entidade deve:

        - Implementar a interface Serializable;
        - Ter os atributos da entidade que representa;
        - Ter construtores;
        - Ter métodos Gettters e Setters;
        - Ter métodos hascode e equals;
        - Ter o método toString;
        - Colocar as anotações para definir a entidade, as colunas e os relacionamentos se tiver;
 */
@Entity
@Table(name = "tb_customer")
public class Customer implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "telephone", length = 11)
    private String telephone;

    @Column(name = "name", length = 255)
    private String name;

    @Column(name = "address", length = 255)
    private String address;

    @JsonIgnore
    @OneToMany(mappedBy = "customer") // Acrescentando , fetch = FetchType.EAGER se tora EAGER Loading e carrega as dependencias, o pedido completo do customer
    private List<Request> requests = new ArrayList<>();

    public Customer() {
    }

    public Customer(String telephone, String name, String address) {
        this.telephone = telephone;
        this.name = name;
        this.address = address;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<Request> getRequests() {
        return requests;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Customer customer = (Customer) o;
        return Objects.equals(telephone, customer.telephone);
    }

    @Override
    public int hashCode() {
        return Objects.hash(telephone);
    }

    @Override
    public String toString() {
        return "Customer{" +
                "telephone='" + telephone + '\'' +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}