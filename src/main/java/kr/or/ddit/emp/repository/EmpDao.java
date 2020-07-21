package kr.or.ddit.emp.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.db.mybatis.MybatisUtil;
import kr.or.ddit.emp.model.EmpVo;

public class EmpDao {
	public List<EmpVo> selectEmpList(){
		
		SqlSession sqlSession = MybatisUtil.getSqlSession();
		List<EmpVo> empList = sqlSession.selectList("emp.selectEmpList");
		sqlSession.close();
		
		return empList;
	}
	
	public static void main(String[] args) {
		EmpDao empDao = new EmpDao();
		List<EmpVo> empList = empDao.selectEmpList();
		for(EmpVo empVo : empList) {
			System.out.println(empVo);
		}
	}
}
