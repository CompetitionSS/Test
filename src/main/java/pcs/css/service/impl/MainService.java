package pcs.css.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pcs.css.dto.MainDTO;
import pcs.css.dto.PageDTO;
import pcs.css.persistance.mapper.IMainMapper;
import pcs.css.service.IMainService;
import pcs.css.util.CmmUtil;

import javax.net.ssl.*;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.util.*;

@Slf4j
@RequiredArgsConstructor
@Service("MainService")
public class MainService implements IMainService {
    private final IMainMapper mainMapper;

    @Override
    public int count(MainDTO mDTO) throws Exception{
        log.info(this.getClass().getName()+".count start!!");

        return mainMapper.count(mDTO);
    }
    @Override
    public int Searchcount(MainDTO mDTO) throws Exception{
        log.info(this.getClass().getName()+".count start!!");

        return mainMapper.Searchcount(mDTO);
    }
    @Transactional
    @Override
    public List<MainDTO> getMainList() throws Exception {

        log.info(this.getClass().getName() + ".getMainList start!");

        return mainMapper.getMainList();

    }
    @Override
    public List<MainDTO> getMainList2(PageDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getMainList start!");

        return mainMapper.getMainList2(pDTO);

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

        // ???????????? ????????????, ????????? ????????????
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
    @Transactional
    @Override
    public void mainCrawling() throws Exception {

        // ?????? ??????(?????? ?????? ????????? ?????? ??? ????????? ??????????????? ???????????? ????????????.)
        log.info(this.getClass().getName() + ".mainCrawling Start!");

        int res = 0; //????????? ?????? (0?????? ?????? ????????? ??????)

        // CGV ?????? ?????? ?????? ????????? ????????? ??????
        String url1 = "https://www.wevity.com/?c=find&s=1&gub=1&cidx=20";
        String url2 = "&gp=";

        for(int url3 = 21; url3< 22;url3++){
            String url = url1+url2+url3;
            Document doc1 = null; //

            if (url1.indexOf("https://") >= 0) {

                MainService.setSSL();
            }
            if (url2.indexOf("https://") >= 0) {

                MainService.setSSL();
            }
            Connection conn1 = Jsoup.connect(url).header("Content-Type", "application/json;charset=UTF-8").userAgent(USER_AGENT).method(Connection.Method.GET).ignoreContentType(true);

            //????????? ??????(http??????????????? ??????, https ??????????????? ????????? ??????)
            doc1 = conn1.get();

            // CGV ??????????????? ?????? ?????? ??? ?????? ????????? ???????????? ?????? ??????
            // <div class="sect-movie-chart"> ??? ?????? ????????? ?????? HTML????????? element??? ?????????
            Elements elements = doc1.select("div.tit");

            for (Element element : elements) {
                String text = element.tagName("a").html();
                String text2;
                String text3 = "";
                int index1 = text.indexOf("\"");
                int index2;
                if (index1 >= 0) {
                    text2 = text.substring(index1 + 1);
                    index2 = text2.indexOf("\"");
                    text3 = text.substring(index1 + 1, index2 + index1 + 1);
                    text3 = text3.replaceAll("amp;", "");

                }


                text = "https://www.wevity.com/" + text3;
                Connection conn = Jsoup.connect(text).header("Content-Type", "application/json;charset=UTF-8").userAgent(USER_AGENT).method(Connection.Method.GET).ignoreContentType(true);
                Document doc = conn.get();
                Elements elements1 = doc.select("div.contest-detail");
                int ListCount = 0;
                List<MainDTO> mList = new ArrayList<>();
                Elements elements2 = doc.select("ul.cd-info-list");

                for (Element value : elements2) {
                    Element element3 = value.tagName("li");
                    mList.add(new MainDTO());
                    for (int i = 0; i < element3.childrenSize(); i++) {
                        HashMap<String, String> mMap = new HashMap<>();

                        switch (i) {
                            case 0:
                            case 3:
                            case 5:
                            case 6:
                            case 8:
                                break;
                            case 1:
                                if (element3.child(i).text().length() > 5) {
                                    mMap.put("candidate", element3.child(i).text().substring(5));

                                } else {
                                    mMap.put("candidate", "????????????");
                                }
                                mList.get(ListCount).setCandidate(mMap.get("candidate"));
                                break;
                            case 4:
                                mMap.put("s_year", element3.child(i).text().substring(5).split("~")[0].trim());
                                mList.get(ListCount).setS_year(mMap.get("s_year"));
                                mMap.put("deadline", element3.child(i).text().substring(5).split("~")[1].split("D")[0].trim());
                                mList.get(ListCount).setDeadline(mMap.get("deadline"));
                                mList.get(ListCount).setB_year(mMap.get("deadline").substring(0, 4));
                                break;
                            case 7:
                                if (element3.child(i).text().length() > 5) {
                                    mMap.put("url", element3.child(i).text().substring(5));

                                } else {
                                    mMap.put("url", "https://www.naver.com/");
                                }
                                mList.get(ListCount).setUrl(mMap.get("url"));
                                break;
                            case 2:
                                mMap.put("organizer", element3.child(i).text().substring(6));
                                mList.get(ListCount).setOrganizer(mMap.get("organizer"));

                                break;
                        }


                        mList.get(ListCount).setArea("??????????????????");


                    }
                    ListCount++;
                }
                ListCount = 0;
                for (Element element2 : elements1) {
                    String c_name = element2.getElementsByClass("tit-area").text();

                    int c_nameIndex = c_name.indexOf("?????????");
                    c_name = c_name.substring(0, c_nameIndex);
                    mList.get(ListCount).setC_name(c_name);
                    log.info(mList.get(ListCount).getC_name());
                    log.info(mList.get(ListCount).getOrganizer());
                    log.info(mList.get(ListCount).getDeadline());
                    log.info(mList.get(ListCount).getB_year());
                    log.info(mList.get(ListCount).getS_year());
                    MainDTO mainDTO = mainMapper.getMainExists(mList.get(ListCount));
                    if (!CmmUtil.nvl(mainDTO.getExists_yn()).equals("Y")) {
                        mainMapper.InsertMainInfo(mList.get(ListCount));
                    }

                    ListCount++;
                }








            }
        }


        // JSOUP ?????????????????? ?????? ????????? ????????????, ??? ???????????? ?????? HTML?????? ????????? ??????

        log.info(this.getClass().getName() + ".mainCrawling End!");

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
