package com.server.services;

import com.server.compositeId.TagId;
import com.server.dto.TagDTO;
import com.server.repository.CategoryRepository;
import com.server.repository.GuideHandleRepository;
import org.springframework.stereotype.Service;
import com.server.entities.Tag;
import com.server.repository.TagRepository;

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

    public void deleteTag(Tag tag) {
        tagRepository.deleteById(new TagId(tag.getTagId().getGuideId(), tag.getTagId().getName()));
    }
}
