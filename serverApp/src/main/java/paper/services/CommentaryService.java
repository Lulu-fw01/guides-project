package paper.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import paper.dto.CommentaryResponseDTO;
import paper.entities.Commentary;
import paper.repository.CommentaryRepository;

import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

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

        checkIfSomeFieldIsNull(commentary);

        commentaryRepository.save(commentary);
    }

    public void deleteCommentary(Commentary commentary) {
        if (commentary == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        checkIfSomeFieldIsNull(commentary);

        if (commentaryRepository.existsById(commentary.getId())) {
            commentaryRepository.deleteById(commentary.getId());
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The commentary by given id does not exist");
        }
    }

    public List<CommentaryResponseDTO> getCommentariesByPost(Long id) {
        if (id == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        var comentaries = commentaryRepository.commentariesByPost(id);

        return comentaries.stream()
                .map(commentary -> new CommentaryResponseDTO(
                        commentary.getId(),
                        commentary.getUserEmail().getEmail(),
                        commentary.getGuideId().getId(),
                        commentary.getEditDate(),
                        commentary.getContent()
                ))
                .toList();
    }

    public void checkIfSomeFieldIsNull(Commentary commentary) {
        if (Stream.of(commentary.getUserEmail(),
                        commentary.getGuideId(),
                        commentary.getEditDate(),
                        commentary.getContent())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format: " +
                            "user email, guide id, edit date, contents");
        }
    }
}
