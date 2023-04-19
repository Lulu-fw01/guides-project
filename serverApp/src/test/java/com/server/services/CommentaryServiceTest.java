package com.server.services;

import com.server.dto.CommentaryDTO;
import com.server.dto.CommentaryIdDTO;
import com.server.entities.Commentary;
import com.server.entities.User;
import com.server.repository.CommentaryRepository;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.server.ResponseStatusException;

import java.sql.Timestamp;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class CommentaryServiceTest {

    @Mock
    private CommentaryRepository commentaryRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private GuideHandleRepository guideHandleRepository;

    @InjectMocks
    private CommentaryService commentaryService;

    @Test
    public void nullBodyRequest() {
        assertThrows(ResponseStatusException.class,
                () -> commentaryService.nullBodyRequestCheck(null)
        );
    }

    @Test
    public void nullField() {
        assertThrows(ResponseStatusException.class,
                () -> commentaryService.checkIfSomeFieldIsNull(new Commentary())
        );
    }

    @Test
    public void getCommentariesByPostWithNullID() {
        assertThrows(ResponseStatusException.class,
                () -> commentaryService.getCommentariesByPost(null)
        );
    }

    @Test
    public void createCommentaryWithIncorrectLengthOfContents() {
        var longString = new String(new char[257]).replace('\0', ' ');

        when(userRepository.findByEmail("email")).thenReturn(Optional.of(new User()));

        assertThrows(ResponseStatusException.class,
                () -> commentaryService.addCommentary(new CommentaryDTO("email", 1L, new Timestamp(System.currentTimeMillis()), "a"))
        );

        assertThrows(ResponseStatusException.class,
                () -> commentaryService.addCommentary(new CommentaryDTO("email", 1L, new Timestamp(System.currentTimeMillis()), longString))
        );
    }

    @Test
    public void createWrongComment() {
        when(userRepository.findByEmail("email")).thenReturn(Optional.of(new User()));

        assertThrows(ResponseStatusException.class,
                () -> commentaryService.addCommentary(new CommentaryDTO("email", 1L, new Timestamp(System.currentTimeMillis()), null))
        );

        assertThrows(ResponseStatusException.class,
                () -> commentaryService.addCommentary(null)
        );
    }


    @Test
    public void deleteEmptyCommentary() {
        assertThrows(ResponseStatusException.class,
                () -> commentaryService.deleteCommentary(new CommentaryIdDTO(null))
        );

        assertThrows(ResponseStatusException.class,
                () -> commentaryService.deleteCommentary(null)
        );
    }
}