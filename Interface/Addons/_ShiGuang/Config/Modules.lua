-- Configure ����ҳ��
local _, R, _, _ = unpack(select(2, ...))


-- BUFF/DEBUFF���
R.Auras = {
	IconSize		= 32,											-- BUFFͼ���С
	IconsPerRow		= 16,											-- BUFFÿ�и���
	Spacing			= 6,											-- BUFFͼ����
	BHPos			= {"CENTER", UIParent, "CENTER", 0, -260},		-- ѪDK����Ĭ��λ��
	StaggerPos		= {"CENTER", UIParent, "CENTER", 0, -290},		-- ̹ɮ����Ĭ��λ��
	TotemsPos		= {"CENTER", UIParent, "CENTER", 0, -260},		-- ͼ������Ĭ��λ��
	MarksmanPos		= {"CENTER", UIParent, "CENTER", 0, -310},		-- ���������Ĭ��λ��
	StatuePos		= {"BOTTOMLEFT", UIParent, 520, 260},			-- ��ɮ����Ĭ��λ��
}



-- С��ͼ
R.Minimap = {
	Pos				= {"TOPRIGHT", UIParent, "TOPRIGHT", 0, 0},	-- С��ͼλ��
}
