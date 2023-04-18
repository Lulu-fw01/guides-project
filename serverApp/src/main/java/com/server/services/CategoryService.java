package com.server.services;

import com.server.entities.Category;
import com.server.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    @Autowired
    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public void createCategory(Category category) {
        if (category == null || category.getName() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (category.getName().length() < 2 || category.getName().length() > 16) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Category name length must not be less than 2 or more than 16");
        }

        categoryRepository.save(category);
    }

    public void deleteCategory(Category category) {
        if (category == null || category.getName() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (categoryRepository.existsById(category.getName())) {
            categoryRepository.deleteById(category.getName());
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The category by given name does not exist");
        }
    }

    public List<Category> getCategories() {
        return categoryRepository.findAll();
    }
}
