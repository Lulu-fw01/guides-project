package paper.controllers;

import org.springframework.web.bind.annotation.*;
import paper.entities.Commentary;
import paper.services.CommentaryService;


@RestController
@RequestMapping("api/v1/commentaries")
public class CommentaryController {

    private final CommentaryService commentaryService;

    public CommentaryController(CommentaryService commentaryService) {
        this.commentaryService = commentaryService;
    }

    @PostMapping
    public void addCommentary(@RequestBody Commentary commentary) {
        commentaryService.addCommentary(commentary);
    }

    @DeleteMapping
    public void deleteCommentary(@RequestBody Commentary commentary) {
        commentaryService.deleteCommentary(commentary);
    }

    // TODO: PUT or PATCH method to edit commentary?

    // TODO: add GetMapping to get commentaries for particular guide
}
