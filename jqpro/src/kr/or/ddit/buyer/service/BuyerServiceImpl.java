package kr.or.ddit.buyer.service;

import java.util.List;

import kr.or.ddit.buyer.dao.BuyerDaoImpl;
import kr.or.ddit.buyer.dao.IBuyerDao;
import kr.or.ddit.buyer.vo.BuyerVO;

public class BuyerServiceImpl implements IBuyerService{
	private IBuyerDao dao;
	
	private BuyerServiceImpl() {
		dao = BuyerDaoImpl.getDao();
	}
	private static IBuyerService service;
	public static IBuyerService getService() {
		if(service==null) service = new BuyerServiceImpl();
		return service;
	}
	
	
	@Override
	public List<BuyerVO> listBuyer() {
		return dao.listBuyer();
	}

	@Override
	public BuyerVO selectBuyer(String id) {
		return dao.selectBuyer(id);
	}
	
}
