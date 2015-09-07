package vn.edu.hcmuaf.util;

import vn.edu.hcmuaf.initListenner.ConfigServiceAndDBAddress;

public class LinkService {
	private static final String DOMAIN = ConfigServiceAndDBAddress.resfulServerAddress;

	// Search Film
	public static final String TOPIMDB = DOMAIN + "/film/topIMDB";
	public static final String TOPNEW = DOMAIN + "/film/topNew";
	public static final String RELATED_MOVIES = DOMAIN + "/film/relatedMovies/{filmId}";
	public static final String SEARCH_FILM = DOMAIN + "/search/{searchData}/all";
	public static final String SEARCH_FILM_BY_STARRING = DOMAIN + "/search/{searchData}/starring";
	public static final String SEARCH_FILM_BY_DIRECTOR = DOMAIN + "/search/{searchData}/director";
	public static final String SEARCH_ALL_FILM = DOMAIN + "/search/all/film";
	public static final String SEARCH_FILM_JSON = DOMAIN + "/film/all.json";

	// Movie
	public static final String MOVIE_GETBY_ID = DOMAIN + "/movie/get/{movieId}";
	public static final String MOVIE_ADD = DOMAIN + "/movie/add";
	public static final String MOVIE_UPDATE = DOMAIN + "/movie/update";

	// Serie
	public static final String SERIE_GETBY_ID = DOMAIN + "/serie/get/{serieId}";
	public static final String SERIE_ADD = DOMAIN + "/serie/add";
	public static final String DERIE_DELETE = DOMAIN + "/serie/delete/{serieId}";
	public static final String SERIE_UPDATE = DOMAIN + "/serie/update";

	// Episode
	public static final String EPISODE_GETBY_ID = DOMAIN + "/episode/get/{epId}";
	public static final String EPISODE_GETALL = DOMAIN + "/episode/all";
	public static final String EPISODE_ADD = DOMAIN + "/episode/add";
	public static final String EPISODE_GETBY_SERIE = DOMAIN + "/episode/getBySerie/{serieId}/{noEpisode}";
	public static final String EPISODE_UPDATE = DOMAIN + "/episode/update";
	public static final String EPISODE_GET_LIST_BY_SERIE = DOMAIN + "/episode/getListBySerie/{serieId}";

	// User
	public static final String USER_GETBY_EMAIL = DOMAIN + "/user/get/{email}/login";
	public static final String USER_GETALL = DOMAIN + "/user/all";
	public static final String USER_ADD = DOMAIN + "/user/add";
	public static final String USER_UPDATE = DOMAIN + "/user/update";

	// Register Film
	public static final String REGIS_ADD = DOMAIN + "/regis/addregis/{email}/{idFilm}/{type}";
	public static final String REGIS_GETBY_ID = DOMAIN + "/regis/getById/{regisId}";
	public static final String REGIS_GETBY_EMAIL = DOMAIN + "/regis/getListByUser/{email}/user";
	public static final String REGIS_GETBY_EMAIL_IDFILM = DOMAIN + "/regis/getRegis/{email}/{idFilm}";
	public static final String REGIS_GET_HISTORY = DOMAIN + "/regis/{email}/infor";

	// Re charge
	public static final String RECHARGE_ADD = DOMAIN + "/recharge/add/{email}/{seri}";
	public static final String RECHARGE_UPDATE = DOMAIN + "/recharge/update";
	public static final String RECHARGE_GETBY_ID = DOMAIN + "/recharge/getById/{rechargeId}";
	public static final String RECHARGE_GETBY_USER = DOMAIN + "/recharge/getByUser/{email}/user";

	// Comment
	public static final String COMMENT_ADD = DOMAIN + "/comment/add";
	public static final String COMMENT_GETBY_ID = DOMAIN + "/comment/getById/{commentId}";
	public static final String COMMENT_GETBY_USER = DOMAIN + "/comment/getByUser/{email}/user";
	public static final String COMMENT_GETBY_MOVIE = DOMAIN + "/comment/getByFilm/{filmId}";

	// Starring
	public static final String STAR_GETBY_ID = DOMAIN + "/starring/get/{starId}";
	public static final String STAR_ADD = DOMAIN + "/starring/add";
	public static final String STAR_UPDATE = DOMAIN + "/starring/update";
	public static final String STAR_GETALL = DOMAIN + "/starring/all";

	// Director
	public static final String DIRECTOR_ADD = DOMAIN + "/director/add";
	public static final String DIRECTOR_GETBY_ID = DOMAIN + "/director/get/{directorId}";
	public static final String DIRECTOR_GETALL = DOMAIN + "/director/all";
	public static final String DIRECTOR_UPDATE = DOMAIN + "/director/update";

	// Country
	public static final String COUNTRY_ADD = DOMAIN + "/country/add";
	public static final String COUNTRY_UPDATE = "";
	public static final String COUNTRY_GETBY_ID = DOMAIN + "/country/get/{countryId}";
	public static final String COUNTRY_GETALL = DOMAIN + "/country/all";

	// Category
	public static final String CATE_ADD = DOMAIN + "/category/add";
	public static final String CATE_UPDATE = DOMAIN + "/category/update";
	public static final String CATE_GETBY_ID = DOMAIN + "/category/get/{cateId}";
	public static final String CATE_GETALL = DOMAIN + "/category/all";

	// http://vodservice-leetrong.rhcloud.com/VOD-ServiceProject/

	// Card
	public static final String CARD_ALL = DOMAIN + "/card/all";
	public static final String CARD_UNUSED = DOMAIN + "/card/all/unused";
	public static final String CARD_UPDATE = DOMAIN + "/card/update";
	public static final String CARD_GETBY_ID = DOMAIN + "/card/getById/{cardId}";
	public static final String CARD_GETBY_SERI = DOMAIN + "/card/getBySeri/{seri}";
	public static final String CARD_ADD = DOMAIN + "/card/add/{value}";

	// MOVIE
	public static final String MOVIE_FILTER = DOMAIN
			+ "/movie/getBy/{orderId}/{categoryId}/{publishYear}/{countryId}/{page}";
	public static final String MOVIE_FILTER_TOTAL_PAGE = DOMAIN
			+ "/movie/getFilterTotalPage/{orderId}/{categoryId}/{publishYear}/{countryId}/{page}";
	// SERIE
	public static final String SERIE_FILTER = DOMAIN
			+ "/serie/getBy/{orderId}/{categoryId}/{publishYear}/{countryId}/{page}";
	public static final String SERIE_FILTER_TOTAL_PAGE = DOMAIN
			+ "/serie/getFilterTotalPage/{orderId}/{categoryId}/{publishYear}/{countryId}/{page}";

}