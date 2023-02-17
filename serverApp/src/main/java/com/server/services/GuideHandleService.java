package com.server.services;

import com.server.dto.GuideDTO;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import com.server.utils.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import com.server.entities.Guide;

import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

@Service
public class GuideHandleService implements Validator<Guide> {

    private final GuideHandleRepository guideHandleRepository;
    private final UserRepository userRepository;

    @Autowired
    public GuideHandleService(GuideHandleRepository guideHandleRepository, UserRepository userRepository) {
        this.guideHandleRepository = guideHandleRepository;
        this.userRepository = userRepository;
    }

    public void createGuide(GuideDTO guideDTO) {
        var guide = new Guide(
                userRepository
                        .findByEmail(guideDTO.getCreatorEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                guideDTO.getTitle(),
                guideDTO.getFileBytes(),
                guideDTO.getEditDate(),
                guideDTO.getIsBlocked()
        );
        nullBodyRequestCheck(guide);

        checkIfSomeFieldIsNull(guide);

        guideHandleRepository.save(guide);
    }

    public void removeGuide(Long id) {
        if (id == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

        if (guideHandleRepository.existsById(id)) {
            guideHandleRepository.deleteById(id);
        } else {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The guide with the specified id does not exist");
        }
    }

    public List<GuideDTO> getListOfAllGuides() {
        var guides = guideHandleRepository.findAll();

        return guides.stream()
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

    public void editGuide(GuideDTO guideDTO) {
        var guide = new Guide(
                guideDTO.getId(),
                userRepository
                        .findByEmail(guideDTO.getCreatorEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                guideDTO.getTitle(),
                guideDTO.getFileBytes(),
                guideDTO.getEditDate(),
                guideDTO.getIsBlocked()
        );

        nullBodyRequestCheck(guide);

        checkIfSomeFieldIsNull(guide);

        var selectedGuideOptional = guideHandleRepository.findById(guide.getId());

        if (selectedGuideOptional.isPresent()) {
            var selectedGuide = selectedGuideOptional.get();

            selectedGuide.setId(guide.getId());
            selectedGuide.setCreatorEmail(guide.getCreatorEmail());
            selectedGuide.setEditDate(guide.getEditDate());
            selectedGuide.setTitle(guide.getTitle());
            selectedGuide.setFileBytes(guide.getFileBytes());
            selectedGuide.setIsBlocked(guide.getIsBlocked());

            guideHandleRepository.save(selectedGuide);
            return;
        }

        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Could not find the guide by given id");
    }

    @Override
    public void checkIfSomeFieldIsNull(Guide obj) {
        if (Stream.of(obj.getCreatorEmail(),
                        obj.getTitle(),
                        obj.getFileBytes(),
                        obj.getEditDate(),
                        obj.getIsBlocked())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format:" +
                            " email, title, file bytes, edit date, isBlocked");
        }
    }

    @Override
    public void nullBodyRequestCheck(Guide obj) {
        if (obj == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }
    }
}
