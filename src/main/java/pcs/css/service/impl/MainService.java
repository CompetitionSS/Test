package pcs.css.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.jasper.tagplugins.jstl.core.Url;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pcs.css.dto.MainDTO;
import pcs.css.persistance.mapper.IMainMapper;
import pcs.css.service.IMainService;
import pcs.css.util.CmmUtil;
import pcs.css.util.DateUtil;

import javax.net.ssl.*;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service("MainService")
public class MainService implements IMainService {
    private final IMainMapper mainMapper;


    @Transactional
    @Override
    public List<MainDTO> getMainList() throws Exception {

        log.info(this.getClass().getName() + ".getMainList start!");

        return mainMapper.getMainList();

    }
    @Transactional
    @Override
    public List<MainDTO> SearchMainList(MainDTO mDTO) throws Exception{
        log.info(this.getClass().getName()+".SearchMainList start!");

        List<MainDTO> mList = mainMapper.SearchMainList(mDTO);
        if(mList==null){
            mList = new ArrayList<>();
        }
        return mList;
    }

    @Transactional
    @Override
    public void InsertMainInfo(MainDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".InsertMainInfo start!");

        mainMapper.InsertMainInfo(pDTO);
    }

    @Transactional
    @Override
    public MainDTO getMainInfo(MainDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getmainInfo start!");

        // 상세보기 할때마다, 조회수 증가하기
        log.info("Update ReadCNT");
        mainMapper.updateMainReadCnt(pDTO);

        return mainMapper.getMainInfo(pDTO);

    }

    @Transactional
    @Override
    public void updateMainInfo(MainDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".updateMainInfo start!");

        mainMapper.updateMainInfo(pDTO);

    }

    @Transactional
    @Override
    public void deleteMainInfo(MainDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".deleteMainInfo start!");

        mainMapper.deleteMainInfo(pDTO);

    }
    public int collectMovieRank() throws Exception {

        // 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
        log.info(this.getClass().getName() + ".collectMovieRank Start!");

        int res = 0; //크롤링 결과 (0보다 크면 크롤링 성공)

        // CGV 영화 순위 정보 가져올 사이트 주소
        String url = "https://www.wevity.com/?c=find&s=1&gub=1&cidx=21";

        // JSOUP 라이브러리를 통해 사이트 접속되면, 그 사이트의 전체 HTML소스 저장할 변수
        Document doc = null; //
        if (url.indexOf("https://") >= 0) {

            MainService.setSSL();
        }
        Connection conn = Jsoup.connect(url).header("Content-Type", "application/json;charset=UTF-8").userAgent(USER_AGENT).method(Connection.Method.GET).ignoreContentType(true);
        //사이트 접속(http프로토롱만 가능, https 프로토콜은 보안상 안됨)
        doc = conn.get();

        // CGV 웹페이지의 전체 소소 중 일부 태그를 선택하기 위해 사용
        // <div class="sect-movie-chart"> 이 태그 내에서 있는 HTML소스만 element에 저장됨
        Elements element = doc.select("div.sect-movie-chart");
        return res;
    }
    private final static String USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36";
    public static void setSSL() throws NoSuchAlgorithmException, KeyManagementException {
        TrustManager[] trustAllCerts = new TrustManager[] {
                new X509TrustManager() {
                    public X509Certificate[] getAcceptedIssuers() {
                        return null;
                    }
                    public void checkClientTrusted(X509Certificate[] certs, String authType) {}
                    public void checkServerTrusted(X509Certificate[] certs, String authType) {}
                }
        };
        SSLContext sc = SSLContext.getInstance("SSL");
        sc.init(null, trustAllCerts, new SecureRandom());
        HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier() {
            @Override public boolean verify(String hostname, SSLSession session) {
                return true;
            }
        });
        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
    }
}
