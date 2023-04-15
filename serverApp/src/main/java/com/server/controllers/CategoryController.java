package com.server.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.server.entities.Category;
import com.server.services.CategoryService;

import java.util.List;

@RestController
@RequestMapping("api/v1/categories")
public class CategoryController {

    private final CategoryService categoryService;

    @Autowired
    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @PostMapping
    @Operation(summary = "Create category")
    @SecurityRequirement(name = "Bearer Authentication")
    public void createCategory(@RequestBody Category category) {
        categoryService.createCategory(category);
    }

    @DeleteMapping
    @Operation(summary = "Delete category")
    @SecurityRequirement(name = "Bearer Authentication")
    public void deleteCategory(@RequestBody Category category) {
        categoryService.deleteCategory(category);
    }

    @GetMapping
    @Operation(summary = "Get all categories")
    @SecurityRequirement(name = "Bearer Authentication")
    public List<Category> getCategories() {
        return categoryService.getCategories();
    }
}
