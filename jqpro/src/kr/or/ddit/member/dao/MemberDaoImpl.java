package kr.or.ddit.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.config.MybatisUtil;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;
import kr.or.ddit.util.DBUtil3;

public class MemberDaoImpl implements IMemberDao {
	
	//싱글톤 자신의 객체 선언
	private static IMemberDao dao;
	
	//db 접근 실행 설정
	private Connection con = null;
				//DBUtil3.getConnection();
	
	private MemberDaoImpl() { }
	
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//싱글톤 생성 -리턴
	public static IMemberDao getDao() {
		if(dao==null) dao = new MemberDaoImpl();
		
		return dao;
	}
	
	
	@Override
	public List<MemberVO> getAllMember() {
		List<MemberVO> list = new ArrayList<MemberVO>();
		String sql = "select * from member";
		
		try {
			con = DBUtil3.getConnection();
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO vo = new MemberVO();
				vo.setMem_id(rs.getString("mem_id"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setMem_hp(rs.getString("mem_hp"));
				
				list.add(vo);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
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

}



