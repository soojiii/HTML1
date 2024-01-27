package kr.or.ddit.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.config.MybatisUtil;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public class MemberDaoImpl implements IMemberDao {
	
	//싱글톤 자신의 객체 선언
	private static IMemberDao dao;
	
	private MemberDaoImpl() { }
	
	//싱글톤 생성 -리턴
	public static IMemberDao getDao() {
		if(dao==null) dao = new MemberDaoImpl();
		
		return dao;
	}
	
	
	@Override
	public String selectById(String id) {
		SqlSession session = MybatisUtil.getSqlSession();
		
		String res = null;
		
		try {
			res = session.selectOne("member.selectById", id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//session.commit();
			session.close();
		}
		return res;
	}


	@Override
	public List<ZipVO> selectByDong(String dong) {
		List<ZipVO> list = null;
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			list = session.selectList("member.selectByDong", dong);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		return list;
	}


	@Override
	public int insertMember(MemberVO vo) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = MybatisUtil.getSqlSession();
			res = session.insert("member.insertMember", vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		
		return res;
	}

	@Override
	public MemberVO logSelect(MemberVO vo) {
		SqlSession session = null;
		MemberVO res = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			res = session.selectOne("member.logSelect", vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		return res;
	}
	

}



