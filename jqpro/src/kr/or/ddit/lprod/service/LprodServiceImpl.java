package kr.or.ddit.lprod.service;

import java.util.List;

import kr.or.ddit.lprod.dao.ILprodDao;
import kr.or.ddit.lprod.dao.LprodDaoImpl;
import kr.or.ddit.lprod.vo.LprodVO;

public class LprodServiceImpl implements ILprodService {

	//dao객체 선언
	private ILprodDao dao;
	
	//싱글톤 자신의 객체 선언
	private static ILprodService service;
	
	//생성자
	private LprodServiceImpl() {
		dao = LprodDaoImpl.getDao();
	}
	
	//자신의 객체 생성, 리턴
	public static ILprodService getservice() {
		if(service==null) service = new LprodServiceImpl();
		return service;
	}
	
	@Override
	public List<LprodVO> selectLprod() {
		return dao.selectLprod();
	}
	
}
