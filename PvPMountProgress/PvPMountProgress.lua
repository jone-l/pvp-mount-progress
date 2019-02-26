hooksecurefunc(PVPQueueFrame.HonorInset.RatedPanel.SeasonRewardFrame, "UpdateTooltip", function(self)
	
	local achievementID = self:GetAchievementID();
	if not achievementID then
		return;
	end
	if GetAchievementNumCriteria(achievementID) == 0 then
		return;
	end
		
	EmbeddedItemTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip_SetTitle(EmbeddedItemTooltip, PVP_SEASON_REWARD);

	local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString = GetAchievementCriteriaInfo(achievementID, 1);
	local victoriesLeft2v2 = math.ceil((reqQuantity-quantity)/10)
	local victoriesLeft3v3 = math.ceil((reqQuantity-quantity)/30)
	local victoriesLeftrbg = math.ceil((reqQuantity-quantity)/60)

	if criteriaString then
		if completed then
			GameTooltip_AddColoredLine(EmbeddedItemTooltip, GOAL_COMPLETED, GREEN_FONT_COLOR);
		else
			local wordWrap = true;
			GameTooltip_AddNormalLine(EmbeddedItemTooltip, criteriaString, wordWrap);
			local roundToNearestInteger = true;
			local progressString = format("%s (%d / %d)", FormatPercentage(quantity / reqQuantity, roundToNearestInteger), quantity, reqQuantity)
			GameTooltip_ShowProgressBar(EmbeddedItemTooltip, 0, reqQuantity, quantity, progressString);
			GameTooltip_AddNormalLine(EmbeddedItemTooltip, format("Victories required:\n    2v2:  %d\n    3v3:  %d\n    RBG: %d", victoriesLeft2v2, victoriesLeft3v3, victoriesLeftrbg), wordWrap)
			local rewardItemID = C_AchievementInfo.GetRewardItemID(achievementID);
			if rewardItemID then
				GameTooltip_AddBlankLinesToTooltip(EmbeddedItemTooltip, 1);
				GameTooltip_AddNormalLine(EmbeddedItemTooltip, REWARD, wordWrap);
				EmbeddedItemTooltip_SetItemByID(EmbeddedItemTooltip.ItemTooltip, rewardItemID);
			end
		end
	end	

	EmbeddedItemTooltip:Show()

end)