package com.server.services;

import com.server.dto.*;
import com.server.repository.GuideHandleRepository;
import com.server.repository.UserRepository;
import com.server.utils.Validator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import com.server.entities.Guide;

import java.sql.Timestamp;
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

    public void createGuide(CreateGuideDTO guideDTO) {
        var guide = new Guide(
                userRepository
                        .findByEmail(guideDTO.getCreatorEmail())
                        .orElseThrow(() -> new UsernameNotFoundException("User does not exist")),
                guideDTO.getTitle(),
                guideDTO.getFileBytes(),
                new Timestamp(System.currentTimeMillis()),
                false
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

    public GuidePageResponse getListOfAllGuides(PageRequestDTO pageRequestDTO) {
        var guides = guideHandleRepository
                .findAll(PageRequest.of(pageRequestDTO.getPageNumber(), pageRequestDTO.getPageSize(),
                        Sort.by("editDate").descending()));

        var guideDTOList = guides.stream()
                .map(guide -> new GuideDTO(
                        guide.getId(),
                        guide.getCreatorEmail().getLogin(),
                        guide.getTitle(),
                        guide.getFileBytes(),
                        guide.getEditDate(),
                        guide.getIsBlocked()
                ))
                .toList();

        return new GuidePageResponse(
                guides.getTotalPages(),
                guideDTOList,
                pageRequestDTO.getPageNumber()
        );
    }

    public void editGuide(GuideDTO guideDTO) {
        var guide = new Guide(
                guideDTO.getId(),
                userRepository
                        .findByEmail(guideDTO.getCreatorLogin())
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

    public GuidePageResponse getListOfGuidesByUser(UserGuidePageDTO userPagingDTO) {
        var pageable =
                PageRequest.of(userPagingDTO.getPageNumber(), userPagingDTO.getPageSize(),
                        Sort.by("guides.edit_date").descending());

        var numOfAllGuidesByUser = guideHandleRepository.findByUser(userPagingDTO.getEmail()).size();

        int totalPages = getTotalPages(userPagingDTO, numOfAllGuidesByUser);

        var guideDTOList = guideHandleRepository
                .findByUser(userPagingDTO.getEmail(), pageable)
                .stream()
                .map(guide -> new GuideDTO(
                        guide.getId(),
                        guide.getCreatorEmail().getLogin(),
                        guide.getTitle(),
                        guide.getFileBytes(),
                        guide.getEditDate(),
                        guide.getIsBlocked()
                ))
                .toList();

        return new GuidePageResponse(
                totalPages,
                guideDTOList,
                userPagingDTO.getPageNumber()
        );
    }

    private int getTotalPages(UserGuidePageDTO userPagingDTO, int numOfAllGuidesByUser) {
        int totalPages;
        if (numOfAllGuidesByUser % userPagingDTO.getPageSize() == 0) {
            totalPages = numOfAllGuidesByUser / userPagingDTO.getPageSize();
        } else {
            totalPages = numOfAllGuidesByUser / userPagingDTO.getPageSize() + 1;
        }
        return totalPages;
    }

    public GuideDTO getGuideById(Long id) {
        if (id == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "The request body is null");
        }
        var guide = guideHandleRepository
                .findById(id)
                .orElseThrow(() -> new IllegalArgumentException("The guide does not exist by given ID"));

        return new GuideDTO(
                guide.getId(),
                guide.getCreatorEmail().getLogin(),
                guide.getTitle(),
                guide.getFileBytes(),
                guide.getEditDate(),
                guide.getIsBlocked()
        );
    }

    public GuideInfoPageResponse getListOfGuideInfoByUser(UserGuidePageDTO userPagingDTO) {
        var pageable =
                PageRequest.of(userPagingDTO.getPageNumber(), userPagingDTO.getPageSize(),
                        Sort.by("guides.edit_date").descending());

        var numOfAllGuidesByUser = guideHandleRepository.findByUser(userPagingDTO.getEmail()).size();

        int totalPages = getTotalPages(userPagingDTO, numOfAllGuidesByUser);

        var guideDTOList = guideHandleRepository
                .findByUser(userPagingDTO.getEmail(), pageable)
                .stream()
                .map(guide -> new GuideInfoDTO(
                        guide.getId(),
                        guide.getCreatorEmail().getLogin(),
                        guide.getTitle(),
                        guide.getEditDate(),
                        guide.getIsBlocked()
                ))
                .toList();

        return new GuideInfoPageResponse(
                totalPages,
                guideDTOList,
                userPagingDTO.getPageNumber()
        );
    }
}
