package com.server.services;

import com.server.repository.GuideHandleRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.server.ResponseStatusException;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(MockitoExtension.class)
class SearchServiceTest {

    @Mock
    private GuideHandleRepository guideHandleRepository;

    @Mock
    private FavoriteItemService favoriteItemService;

    @InjectMocks
    private SearchService searchService;

    @Test
    public void passNullsToSearch() {
        assertThrows(ResponseStatusException.class,
                () -> searchService.getGuidesByAuthor(null, null, null)
        );

        assertThrows(ResponseStatusException.class,
                () -> searchService.getGuidesByTitle(null, "1", null)
        );

        assertThrows(ResponseStatusException.class,
                () -> searchService.getGuidesByCategory(null, "1", "1")
        );
    }

    @Test
    public void passWrongPageSize() {
        assertThrows(ResponseStatusException.class,
                () -> searchService.getGuidesByCategory("category", "0", "0")
        );

        assertThrows(ResponseStatusException.class,
                () -> searchService.getGuidesByAuthor("category", "0", "0")
        );

        assertThrows(ResponseStatusException.class,
                () -> searchService.getGuidesByTitle("category", "0", "-1")
        );
    }

    @Test
    public void usePageParamsThatCannotBeParsedToInt() {
        assertThrows(ResponseStatusException.class,
                () -> searchService.getGuidesByCategory("category", "sdfs", "fsd")
        );

        assertThrows(ResponseStatusException.class,
                () -> searchService.getGuidesByAuthor("category", "fsdf", "dsfsd")
        );

        assertThrows(ResponseStatusException.class,
                () -> searchService.getGuidesByTitle("category", "", "fsdf")
        );
    }
}