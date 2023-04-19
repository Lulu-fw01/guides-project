package com.server.services;

import com.server.dto.CommentaryDTO;
import com.server.dto.CommentaryIdDTO;
import com.server.entities.Commentary;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import com.server.utils.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import com.server.repository.CommentaryRepository;

import java.sql.Timestamp;
import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

@Service
public class CommentaryService implements Validator<Commentary> {

    private final CommentaryRepository commentaryRepository;
    private final UserRepository userRepository;
    private final GuideHandleRepository guideHandleRepository;

    @Autowired
    public CommentaryService(CommentaryRepository commentaryRepository,
                             UserRepository userRepository,
                             GuideHandleRepository guideHandleRepository) {
        this.commentaryRepository = commentaryRepository;
        this.userRepository = userRepository;
        this.guideHandleRepository = guideHandleRepository;
    }

    public void addCommentary(CommentaryDTO commentaryDTO) {
        if (commentaryDTO == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Request body is null");
        }

        var commentary = new Commentary(
                userRepository
                        .findByEmail(commentaryDTO.getUserEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("The user does not exist")),
                guideHandleRepository
                        .findById(commentaryDTO.getGuideId())
                        .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "The guide does not exist")),
                new Timestamp(System.currentTimeMillis()),
                commentaryDTO.getContents()
        );

        nullBodyRequestCheck(commentary);

        checkIfSomeFieldIsNull(commentary);

        if (commentaryDTO.getContents().length() < 1 || commentaryDTO.getContents().length() > 256) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Comment contents length must not be less than 1 or more than 256");
        }

        commentaryRepository.save(commentary);
    }

    public void deleteCommentary(CommentaryIdDTO commentaryDTO) {
        if (commentaryDTO == null || commentaryDTO.getId() == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (commentaryRepository.existsById(commentaryDTO.getId())) {
            commentaryRepository.deleteById(commentaryDTO.getId());
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The commentary by given id does not exist");
        }
    }

    public List<CommentaryDTO> getCommentariesByPost(Long id) {
        if (id == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        var commentaries = commentaryRepository.commentariesByPost(id);

        return commentaries.stream()
                .map(commentary -> new CommentaryDTO(
                        commentary.getUserEmail().getEmail(),
                        commentary.getGuideId().getId(),
                        commentary.getEditDate(),
                        commentary.getContent()
                ))
                .toList();
    }

    @Override
    public void checkIfSomeFieldIsNull(Commentary obj) {
        if (Stream.of((obj).getUserEmail(),
                        (obj).getGuideId(),
                        (obj).getEditDate(),
                        (obj).getContent())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format: " +
                            "user email, guide id, edit date, contents");
        }
    }

    @Override
    public void nullBodyRequestCheck(Commentary obj) {
        if (obj == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }
    }
}
