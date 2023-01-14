package com.server.services;

import com.server.dto.GuideDTO;
import com.server.repository.GuideHandleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import com.server.entities.Guide;

import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

@Service
public class GuideHandleService {

    private final GuideHandleRepository guideHandleRepository;

    @Autowired
    public GuideHandleService(GuideHandleRepository guideHandleRepository) {
        this.guideHandleRepository = guideHandleRepository;
    }

    public void createGuide(Guide guide) {
        if (guide == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

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

    public void editGuide(Guide guide) {
        if (guide == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }

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

    private void checkIfSomeFieldIsNull(Guide guide) {
        if (Stream.of(guide.getCreatorEmail(),
                        guide.getTitle(),
                        guide.getFileBytes(),
                        guide.getEditDate(),
                        guide.getIsBlocked())
                .anyMatch(Objects::isNull)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "One of the transferred attributes is null." +
                            " Consider sending request in the following format:" +
                            " email, title, file bytes, edit date, isBlocked");
        }
    }
}
