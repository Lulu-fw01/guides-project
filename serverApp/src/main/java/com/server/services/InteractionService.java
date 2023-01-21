package com.server.services;

import com.server.compositeId.InteractionId;
import com.server.dto.GuideDTO;
import com.server.dto.InteractionDTO;
import com.server.dto.UserDTO;
import com.server.entities.Interaction;
import com.server.repository.GuideHandleRepository;
import com.server.repository.InteractionRepository;
import com.server.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class InteractionService {

    private final InteractionRepository interactionRepository;
    private final UserRepository userRepository;
    private final GuideHandleRepository guideHandleRepository;

    @Autowired
    public InteractionService(InteractionRepository interactionRepository,
                              UserRepository userRepository,
                              GuideHandleRepository guideHandleRepository) {
        this.interactionRepository = interactionRepository;
        this.userRepository = userRepository;
        this.guideHandleRepository = guideHandleRepository;
    }

    public List<InteractionDTO> getPostsUserInteractedWith(UserDTO userDTO) {
        return interactionRepository
                .getPostsUserInteractedWith(userDTO.getEmail())
                .stream()
                .map(interaction -> new InteractionDTO(
                       interaction.getInteractionId().getEmail().getEmail(),
                       interaction.getInteractionId().getId().getId(),
                       interaction.getUsersMark(),
                       interaction.getViewDate()
                ))
                .toList();
    }

    public void setReaction(InteractionDTO interactionDTO) {
        var interaction = new Interaction(
                new InteractionId(
                        userRepository
                                .findByEmail(interactionDTO.getUserEmail())
                                .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                        guideHandleRepository
                                .findById(interactionDTO.getGuideId())
                                .orElseThrow(() -> new IllegalArgumentException("The guide does not exist"))
                ),
                interactionDTO.getUsersMark(),
                interactionDTO.getViewDate()
        );

        interactionRepository.save(interaction);
    }

    public void deleteReaction(InteractionDTO interactionDTO) {
        var id = new InteractionId(
                userRepository
                        .findByEmail(interactionDTO.getUserEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                guideHandleRepository
                        .findById(interactionDTO.getGuideId())
                        .orElseThrow(() -> new IllegalArgumentException("The guide does not exist"))
        );

        if (interactionRepository.existsById(id)) {
            interactionRepository.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Id does not exist");
        }
    }

    // TODO: fix the methods below
    public List<GuideDTO> getTopRated() {
        return interactionRepository
                .getTopRated()
                .stream()
                .map(rated -> guideHandleRepository
                        .findById(rated.getGuideId())
                        .orElseThrow(() -> new IllegalArgumentException("Guide does not exist")))
                .map(guide -> new GuideDTO(
                       guide.getId(),
                       guide.getCreatorEmail().getEmail(),
                       guide.getTitle(),
                       guide.getFileBytes(),
                       guide.getEditDate(),
                       guide.getIsBlocked()
                ))
                .toList();
    }

    public List<GuideDTO> getRecentlyViewed(UserDTO user) {
        var ids = interactionRepository
                .getRecentlyViewed(user.getEmail())
                .stream()
                .map(InteractionDTO::getGuideId)
                .toList();


        return guideHandleRepository
                .findByIds(ids)
                .stream()
                .map(guide -> new GuideDTO(
                        guide.getId(),
                        guide.getCreatorEmail().getEmail(),
                        guide.getTitle(),
                        guide.getFileBytes(),
                        guide.getEditDate(),
                        guide.getIsBlocked()
                ))
                .toList();
    }
}
