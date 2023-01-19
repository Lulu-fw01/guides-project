package com.server.services;

import com.server.dto.CommentaryDTO;
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
        var commentary = new Commentary(
                commentaryDTO.getId(),
                userRepository
                        .findByEmail(commentaryDTO.getUserEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("The user does not exist")),
                guideHandleRepository
                        .findById(commentaryDTO.getGuideId())
                        .orElseThrow(() -> new IllegalArgumentException("The guide does not exist")),
                commentaryDTO.getEditDate(),
                commentaryDTO.getContents()
        );

        nullBodyRequestCheck(commentary);

        checkIfSomeFieldIsNull(commentary);

        commentaryRepository.save(commentary);
    }

    public void deleteCommentary(CommentaryDTO commentaryDTO) {
        var commentary = new Commentary(
                commentaryDTO.getId(),
                userRepository
                        .findByEmail(commentaryDTO.getUserEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("The user does not exist")),
                guideHandleRepository
                        .findById(commentaryDTO.getGuideId())
                        .orElseThrow(() -> new IllegalArgumentException("The guide does not exist")),
                commentaryDTO.getEditDate(),
                commentaryDTO.getContents()
        );

        nullBodyRequestCheck(commentary);

        checkIfSomeFieldIsNull(commentary);

        if (commentaryRepository.existsById(commentary.getId())) {
            commentaryRepository.deleteById(commentary.getId());
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The commentary by given id does not exist");
        }
    }

    public List<CommentaryDTO> getCommentariesByPost(Long id) {
        if (id == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        var comentaries = commentaryRepository.commentariesByPost(id);

        return comentaries.stream()
                .map(commentary -> new CommentaryDTO(
                        commentary.getId(),
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
