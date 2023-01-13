package paper.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import paper.entities.Category;
import paper.services.CategoryService;

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
    public void createCategory(@RequestBody Category category) {
        categoryService.createCategory(category);
    }

    @DeleteMapping
    public void deleteCategory(@RequestBody Category category) {
        categoryService.deleteCategory(category);
    }

    @GetMapping
    public List<Category> getCategories() {
        return categoryService.getCategories();
    }
}
