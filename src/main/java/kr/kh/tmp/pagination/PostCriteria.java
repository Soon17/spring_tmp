package kr.kh.tmp.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PostCriteria extends Criteria {

	int bo_num;

	@Override
	public String toString() {
		return "PostCriteria [bo_num=" + bo_num + "," + super.toString() +  "]";
	}
	
}