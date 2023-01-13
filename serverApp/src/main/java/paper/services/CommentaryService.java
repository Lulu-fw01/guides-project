package paper.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import paper.entities.Commentary;
import paper.repository.CommentaryRepository;

@Service
public class CommentaryService {

    private final CommentaryRepository commentaryRepository;

    @Autowired
    public CommentaryService(CommentaryRepository commentaryRepository) {
        this.commentaryRepository = commentaryRepository;
    }

    public void addCommentary(Commentary commentary) {
        if (commentary == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        commentaryRepository.save(commentary);
    }

    public void deleteCommentary(Commentary commentary) {
        if (commentary == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        commentaryRepository.deleteById(commentary.getId());
    }
}
