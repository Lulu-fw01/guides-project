package com.server.services;

import com.server.compositeId.TagId;
import com.server.dto.TagDTO;
import com.server.repository.CategoryRepository;
import com.server.repository.GuideHandleRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import com.server.entities.Tag;
import com.server.repository.TagRepository;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class TagService {

    private final TagRepository tagRepository;
    private final GuideHandleRepository guideHandleRepository;
    private final CategoryRepository categoryRepository;

    public TagService(TagRepository tagRepository,
                      GuideHandleRepository guideHandleRepository,
                      CategoryRepository categoryRepository) {
        this.tagRepository = tagRepository;
        this.guideHandleRepository = guideHandleRepository;
        this.categoryRepository = categoryRepository;
    }

    public void addTag(TagDTO tagDTO) {
        var tag = new Tag(
                new TagId(
                        guideHandleRepository
                                .findById(tagDTO.getGuideId())
                                .orElseThrow(() -> new IllegalArgumentException("Guide does not exist")),
                        categoryRepository
                                .findById(tagDTO.getCategory())
                                .orElseThrow(() -> new IllegalArgumentException("Category does not exist"))
                )
        );
        tagRepository.save(tag);
    }

    public void deleteTag(TagDTO tagDTO) {
        var id = new TagId(
                guideHandleRepository
                        .findById(tagDTO.getGuideId())
                        .orElseThrow(() -> new IllegalArgumentException("Guide does not exist")),
                categoryRepository
                        .findById(tagDTO.getCategory())
                        .orElseThrow(() -> new IllegalArgumentException("Category does not exist"))
        );

        if (tagRepository.existsById(id)) {
            tagRepository.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The id does not exist");
        }
    }

    public List<String> getTags(Long id) {
        return tagRepository
                .findTagsByGuideId(id);
    }
}
