package paper.controllers;

import org.springframework.web.bind.annotation.*;
import paper.models.Tag;
import paper.services.TagService;

@RestController
@RequestMapping("api/v1/tags")
public class TagController {

    private final TagService tagService;

    public TagController(TagService tagService) {
        this.tagService = tagService;
    }

    @PostMapping
    public void addTag(@RequestBody Tag tag) {
        tagService.addTag(tag);
    }

    // TODO: fix deleting
//    @DeleteMapping
//    public void deleteTag(@RequestBody Tag tag) {
//        tagService.deleteTag(tag);
//    }
}
