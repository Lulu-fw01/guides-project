package com.server.services;

import com.server.compositeId.TagId;
import org.springframework.stereotype.Service;
import com.server.entities.Tag;
import com.server.repository.TagRepository;

@Service
public class TagService {

    private final TagRepository tagRepository;

    public TagService(TagRepository tagRepository) {
        this.tagRepository = tagRepository;
    }

    public void addTag(Tag tag) {
        tagRepository.save(tag);
    }

    public void deleteTag(Tag tag) {
        tagRepository.deleteById(new TagId(tag.getTagId().getGuideId(), tag.getTagId().getName()));
    }
}
