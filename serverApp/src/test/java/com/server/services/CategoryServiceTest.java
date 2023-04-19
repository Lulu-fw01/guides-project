package com.server.services;

import com.server.entities.Category;
import com.server.repository.CategoryRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;


import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class CategoryServiceTest {

    @InjectMocks
    private CategoryService categoryService;

    @Mock
    private CategoryRepository categoryRepository;

    private Category category;

    @BeforeEach
    public void initCategory() {
        category = new Category("category");
    }

    @Test
    public void createCategoryWithNullRequestBody() {
        assertThrows(ResponseStatusException.class,
                () -> categoryService.createCategory(null),
                "The request body is null");
    }

    @Test
    public void createCategoryNormally() {
        when(categoryRepository.save(category)).thenReturn(category);

        assertEquals(categoryRepository.save(category), category);

        verify(categoryRepository, times(1)).save(category);
    }

    @Test
    public void createCategoryWithIncorrectName() {
        assertThrows(ResponseStatusException.class,
                () -> categoryService.createCategory(new Category("a"))
        );

        assertThrows(ResponseStatusException.class,
                () -> categoryService.createCategory(new Category("aaaaaaaaaaaaaaaaa"))
        );
    }

    @Test
    public void deleteCategoryWithNullRequestBody() {
        assertThrows(ResponseStatusException.class,
                () -> categoryService.deleteCategory(null),
                "The request body is null");
    }

    @Test
    public void deleteExistingCategory() {
        when(categoryRepository.existsById(anyString())).thenReturn(true);

        categoryService.deleteCategory(category);

        verify(categoryRepository, times(1)).deleteById(category.getName());
    }

    @Test
    public void deleteNonExistingCategory() {
        when(categoryRepository.existsById(anyString())).thenReturn(false);

        assertThrows(ResponseStatusException.class,
                () -> categoryService.deleteCategory(category),
                "The category by given name does not exist");
    }

    @Test
    public void getCategories() {
        when(categoryRepository.findAll()).thenReturn(List.of(category));

        assertEquals(categoryService.getCategories(), List.of(category));
    }
}