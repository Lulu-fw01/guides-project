package com.server.services;

import com.server.dto.TagDTO;
import com.server.entities.Category;
import com.server.entities.Guide;
import com.server.repository.CategoryRepository;
import com.server.repository.GuideHandleRepository;
import com.server.repository.TagRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TagServiceTest {

    @Mock
    private TagRepository tagRepository;

    @Mock
    private GuideHandleRepository guideHandleRepository;

    @Mock
    private CategoryRepository categoryRepository;

    @InjectMocks
    private TagService tagService;

    @Test
    public void getTagsNull() {
        assertThrows(ResponseStatusException.class,
                () -> tagService.getTags(null)
        );
    }

    @Test
    public void getTagsFromDB() {
        when(tagRepository.findTagsByGuideId(0L)).thenReturn(new ArrayList<>());

        tagService.getTags(0L);
        verify(tagRepository, times(1)).findTagsByGuideId(0L);
    }

    @Test
    public void addTagNullRequestBody() {
        assertThrows(ResponseStatusException.class,
                () -> tagService.addTag(null)
        );
    }

    @Test
    public void addTagWithNullFields() {
        assertThrows(ResponseStatusException.class,
                () -> tagService.addTag(new TagDTO(null, "cat"))
        );

        assertThrows(ResponseStatusException.class,
                () -> tagService.addTag(new TagDTO(0L, null))
        );

        assertThrows(ResponseStatusException.class,
                () -> tagService.addTag(new TagDTO(null, null))
        );
    }

    @Test
    public void saveTag() {
        when(guideHandleRepository.findById(0L)).thenReturn(Optional.of(new Guide()));
        when(categoryRepository.findById("cat")).thenReturn(Optional.of(new Category()));

        tagService.addTag(new TagDTO(0L, "cat"));
    }

    @Test
    public void deleteTagNull() {
        assertThrows(ResponseStatusException.class,
                () -> tagService.deleteTag(null)
        );
    }

    @Test
    public void deleteTagWithNullFields() {
        assertThrows(ResponseStatusException.class,
                () -> tagService.deleteTag(new TagDTO(null, null))
        );

        assertThrows(ResponseStatusException.class,
                () -> tagService.deleteTag(new TagDTO(0L, null))
        );

        assertThrows(ResponseStatusException.class,
                () -> tagService.deleteTag(new TagDTO(null, "null"))
        );
    }
}