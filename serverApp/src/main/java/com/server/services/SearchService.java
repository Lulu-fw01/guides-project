package com.server.services;

import com.server.dto.GuideDTO;
import com.server.repository.GuideHandleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Component
public class SearchService {

    private final GuideHandleRepository guideHandleRepository;

    @Autowired
    public SearchService(GuideHandleRepository guideHandleRepository) {
        this.guideHandleRepository = guideHandleRepository;
    }

    public List<GuideDTO> getGuidesByTitle(String title, String pageNumber, String pageSize) {
        if (title == null || pageNumber == null || pageSize == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "One of the parameters is null");
        }

        try {
            return guideHandleRepository
                    .searchByTitle(title, PageRequest.of(Integer.parseInt(pageNumber), Integer.parseInt(pageSize), Sort.by("id")))
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
        } catch (NumberFormatException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cannot parse pageNumber and/or pageSize values to Integer");
        }
    }

    public List<GuideDTO> getGuidesByCategory(String category, String pageNumber, String pageSize) {
        if (category == null || pageNumber == null || pageSize == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "One of the parameters is null");
        }

        try {
            return guideHandleRepository
                    .searchByCategory(category, PageRequest.of(Integer.parseInt(pageNumber), Integer.parseInt(pageSize), Sort.by("id")))
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
        } catch (NumberFormatException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cannot parse pageNumber and/or pageSize values to Integer");
        }
    }

    public List<GuideDTO> getGuidesByAuthor(String author, String pageNumber, String pageSize) {
        if (author == null || pageNumber == null || pageSize == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "One of the parameters is null");
        }

        try {
            return guideHandleRepository
                    .searchByAuthor(author, PageRequest.of(Integer.parseInt(pageNumber), Integer.parseInt(pageSize), Sort.by("id")))
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
        } catch (NumberFormatException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Cannot parse pageNumber and/or pageSize values to Integer");
        }
    }
}
