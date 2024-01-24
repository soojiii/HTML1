package kr.or.ddit.lprod.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.lprod.vo.LprodVO;
import kr.or.ddit.util.DBUtil3;

public class LprodDaoImpl implements ILprodDao{
	//싱글톤 자신의 객체
	private static ILprodDao dao;
	
	private LprodDaoImpl() { }
	
	//자신의 객체를 생성하고 리턴하는 메소드
	public static ILprodDao getDao() {
		if(dao==null) dao = new LprodDaoImpl();
		return dao;
	}
	
	//db와 연결되는 객체들 
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	@Override
	public List<LprodVO> selectLprod() {
		List<LprodVO> list = new ArrayList<LprodVO>();

		String sql = "select * from lprod";
		try {
			conn = DBUtil3.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
		while(rs.next()) {
			//vo객체 생성
			LprodVO vo = new LprodVO();
			vo.setLprod_id(rs.getInt("lprod_id"));
			vo.setLprod_gu(rs.getString("lprod_gu"));
			vo.setLprod_nm(rs.getString("lprod_nm"));
			list.add(vo);
		}
		
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

}
