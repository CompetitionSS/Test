package pcs.css.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pcs.css.dto.MainDTO;
import pcs.css.persistance.mapper.IMainMapper;
import pcs.css.service.IMainService;

import java.util.ArrayList;
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
}
