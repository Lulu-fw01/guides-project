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
import java.util.Objects;
import java.util.stream.Stream;

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
        if (tagDTO == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (Stream.of(tagDTO.getCategory(), tagDTO.getGuideId())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Some of the attributes are null. \n" +
                    "Consider using guideId, category");
        }

        var tag = new Tag(
                new TagId(
                        guideHandleRepository
                                .findById(tagDTO.getGuideId())
                                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Guide does not exist")),
                        categoryRepository
                                .findById(tagDTO.getCategory())
                                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Category does not exist"))
                )
        );
        tagRepository.save(tag);
    }

    public void deleteTag(TagDTO tagDTO) {
        if (tagDTO == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (Stream.of(tagDTO.getCategory(), tagDTO.getGuideId())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Some of the attributes are null. \n" +
                    "Consider using guideId, category");
        }

        var id = new TagId(
                guideHandleRepository
                        .findById(tagDTO.getGuideId())
                        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Guide does not exist")),
                categoryRepository
                        .findById(tagDTO.getCategory())
                        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Category does not exist"))
        );

        if (tagRepository.existsById(id)) {
            tagRepository.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The id does not exist");
        }
    }

    public List<String> getTags(Long id) {
        if (id == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        return tagRepository
                .findTagsByGuideId(id);
    }
}
