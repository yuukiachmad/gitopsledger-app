package com.opsledger.account.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.opsledger.account.model.Role;

public interface RoleRepository extends JpaRepository<Role, Long>{
}
