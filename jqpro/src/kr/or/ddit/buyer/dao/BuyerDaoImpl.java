package kr.or.ddit.buyer.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.buyer.vo.BuyerVO;
import kr.or.ddit.config.MybatisUtil;

public class BuyerDaoImpl implements IBuyerDao{
	private static IBuyerDao dao;
	private BuyerDaoImpl() { }
	public static IBuyerDao getDao() {
		if(dao==null) dao = new BuyerDaoImpl();
		return dao;
	}
	
	
	@Override
	public List<BuyerVO> listBuyer() {
		SqlSession session = null;
		List<BuyerVO> list = null;
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("buyer.listBuyer");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return list;
	}
	
	@Override
	public BuyerVO selectBuyer(String id) {
		
		SqlSession session = null;
		BuyerVO vo = null;
		try {
			session = MybatisUtil.getSqlSession();
			vo = session.selectOne("buyer.selectBuyer", id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(session!=null) session.close();
		}
		
		return vo;
	}
	
	
	
}
