package paper.services;

import org.springframework.stereotype.Service;
import paper.compositeId.TagId;
import paper.models.Tag;
import paper.repository.TagRepository;

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
